module StatementLinesHelper

  # toggles creation/deletion of an expense for a statement line using AJAX
  def expense_toggle_check_box(line)
    options = {
      :class => 'expense_toggler', 
      :data => {
        :remote => true, :url => update_expense_statement_line_path(line.id), 
        :method => :put
      }
    }
    check_box_tag("create_expense", "true", line.has_expense?, options)
  end
  
end