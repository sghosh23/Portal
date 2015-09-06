class AccountsController < ApplicationController

  def index

    #@nbilling = account.client
    #@services = account.client.operations
    #response = account.client.call(:get_user_id, message: {username: 'testuser'})
    response = user_id
    #response = account.get_user_id('testuser')
    #resp= response.body
    @response = user_id[:get_user_id_response][:return].to_i
    #@response = resresponse.body
  end

  private
   def user_id
     user_id = account.client.call(:get_user_id, message: {username: 'testuser'})
     user_id.body
   end
   def account
     Account.new
   end
end
