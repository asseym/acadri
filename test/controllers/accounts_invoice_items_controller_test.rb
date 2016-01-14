require 'test_helper'

class AccountsInvoiceItemsControllerTest < ActionController::TestCase
  setup do
    @accounts_invoice_item = accounts_invoice_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts_invoice_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accounts_invoice_item" do
    assert_difference('AccountsInvoiceItem.count') do
      post :create, accounts_invoice_item: { description: @accounts_invoice_item.description, subtotal: @accounts_invoice_item.subtotal, unit_cost: @accounts_invoice_item.unit_cost, units: @accounts_invoice_item.units }
    end

    assert_redirected_to accounts_invoice_item_path(assigns(:accounts_invoice_item))
  end

  test "should show accounts_invoice_item" do
    get :show, id: @accounts_invoice_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accounts_invoice_item
    assert_response :success
  end

  test "should update accounts_invoice_item" do
    patch :update, id: @accounts_invoice_item, accounts_invoice_item: { description: @accounts_invoice_item.description, subtotal: @accounts_invoice_item.subtotal, unit_cost: @accounts_invoice_item.unit_cost, units: @accounts_invoice_item.units }
    assert_redirected_to accounts_invoice_item_path(assigns(:accounts_invoice_item))
  end

  test "should destroy accounts_invoice_item" do
    assert_difference('AccountsInvoiceItem.count', -1) do
      delete :destroy, id: @accounts_invoice_item
    end

    assert_redirected_to accounts_invoice_items_path
  end
end
