# -*- coding: utf-8 -*-
"""
   This script will convert a table to an excel spreadsheet. If the third-party
   module xlwt is available, it will use that. Otherwise, it will fall back to
   CSV.
"""
import arcpy
import os

def header_and_iterator(dataset_name):
    """Returns a list of column names and an iterator over the same columns"""

    data_description = arcpy.Describe(dataset_name)
    fieldnames = [f.name for f in data_description.fields if f.type not in ["Geometry", "Raster", "Blob"]]
    def iterator_for_feature():
        cursor = arcpy.SearchCursor(dataset_name)
        row = cursor.next()
        while row:
            yield [getattr(row, col) for col in fieldnames]
            row = cursor.next()
        del row, cursor
    return fieldnames, iterator_for_feature()

def export_to_csv(dataset, output):
    """Output the data to a CSV file"""
    import csv

    def _encode(x):
        if isinstance(x, unicode):
            return x.encode("utf-8")
        else:
            return str(x)

    def _encodeHeader(x):
        return _encode(x.replace(".","_"))
        
    out_writer = csv.writer(open(output, 'wb'))
    header, rows = header_and_iterator(dataset)
    out_writer.writerow(map(_encodeHeader, header))
    for row in rows:
        out_writer.writerow(map(_encode, row))

def export_to_xls(dataset, output):
    """
    Attempt to output to an XLS file. If xmlwt is not available, fall back
    to CSV.
       
    XLWT can be downloaded from http://pypi.python.org/pypi/xlwt"""
    try:
        import xlwt
    except ImportError:
        arcpy.AddError("import of xlwt module failed")
        return
    header, rows = header_and_iterator(dataset)

    # Make spreadsheet
    workbook = xlwt.Workbook()
    worksheet = workbook.add_sheet(os.path.split(dataset)[1])

    #Set up header row, freeze panes
    header_style = xlwt.easyxf("font: bold on; align: horiz center")
    for index, colheader in enumerate(header):
        worksheet.write(0, index, colheader.replace(".","_"))
    worksheet.set_panes_frozen(True)
    worksheet.set_horz_split_pos(1)
    worksheet.set_remove_splits(True)

    # Write rows
    for rowidx, row in enumerate(rows):
        for colindex, col in enumerate(row):
            worksheet.write(rowidx+1, colindex, col)

    # All done
    workbook.save(output)
    
if __name__ == "__main__":
    dataset_name = arcpy.GetParameterAsText(0)
    output_file = arcpy.GetParameterAsText(1)
    format = arcpy.GetParameterAsText(2)

    if format == "CSV":
        export_to_csv(dataset_name, output_file)
    elif format == "XLS":
        try:
            export_to_xls(dataset_name, output_file)
        except:
            import traceback
            arcpy.AddError(traceback.format_exc())
    else:
        raise ValueError("Don't know how to export to %r" % format)
    
print "FINISHED"
