require File.dirname(__FILE__) + '/../test_helper'
require 'expense_categories_controller'

# Re-raise errors caught by the controller.
class ExpenseCategoriesController; def rescue_action(e) raise e end; end

class ExpenseCategoriesControllerTest < Test::Unit::TestCase
  fixtures :expense_categories

  def setup
    @controller = ExpenseCategoriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:expense_categories)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:expense_category)
    assert assigns(:expense_category).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:expense_category)
  end

  def test_create
    num_expense_categories = ExpenseCategory.count

    post :create, :expense_category => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_expense_categories + 1, ExpenseCategory.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:expense_category)
    assert assigns(:expense_category).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil ExpenseCategory.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      ExpenseCategory.find(1)
    }
  end
end
