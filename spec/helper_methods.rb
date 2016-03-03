module HelperMethods
  
  def parse_response res
    JSON.parse(res,symbolize_names: true)
  end

  def basic_auth username,password
    ActionController::HttpAuthentication::Basic.encode_credentials username, password
  end
  
end