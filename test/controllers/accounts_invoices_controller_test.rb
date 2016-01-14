require 'test_helper'

class AccountsInvoicesControllerTest < ActionController::TestCase
  setup do
    @accounts_invoice = accounts_invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts_invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accounts_invoice" do
    assert_difference('AccountsInvoice.count') do
      post :create, accounts_invoice: { currency: @accounts_invoice.currency, invoice_date: @accounts_invoice.invoice_date, invoice_terms: @accounts_invoice.invoice_terms, training_id: @accounts_invoice.training_id }
    end

    assert_redirected_to accounts_invoice_path(assigns(:accounts_invoice))
  end

  test "should show accounts_invoice" do
    get :show, id: @accounts_invoice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accounts_invoice
    assert_response :success
  end

  test "should update accounts_invoice" do
    patch :update, id: @accounts_invoice, accounts_invoice: { currency: @accounts_invoice.currency, invoice_date: @accounts_invoice.invoice_date, invoice_terms: @accounts_invoice.invoice_terms, training_id: @accounts_invoice.training_id }
    assert_redirected_to accounts_invoice_path(assigns(:accounts_invoice))
  end

  test "should destroy accounts_invoice" do
    assert_difference('AccountsInvoice.count', -1) do
      delete :destroy, id: @accounts_invoice
    end

    assert_redirected_to accounts_invoices_path
  end
end
