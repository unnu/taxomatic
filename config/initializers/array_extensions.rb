class Array
  def except(*items)
    self.reject { |item| items.include?(item) }
  end

  def to_xls
    return_string generate_excel_doc
  end

  def to_xls_file(path)
    open(path, 'w') { |f| f << self.to_xls }
  end

  private
    def generate_excel_doc
      spreadsheet_book = Spreadsheet::Workbook.new
      sheet1 = spreadsheet_book.create_worksheet
      self.each_with_index do |row, index|
        row.each do |column|
          sheet1.row(index).push column
        end
      end
      spreadsheet_book
    end

    def return_string(spreadsheet_book)
      io = StringIO.new
      spreadsheet_book.write io
      io.string
    end
end
