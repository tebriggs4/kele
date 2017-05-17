require "httparty"
require "json"

class Kele
    include HTTParty
    
    def initialize(email, password)
        response = self.class.post(api_url("sessions"), header: "application/json", body: {"email": email, "password": password})
        raise "Invalid userid or password" if (response.code == 401 || response.code == 404)
        @auth_token = response["auth_token"]
    end
    
    def get_me
        response = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
        @user_data = JSON.parse(response.body)
    end
    
    private
    
    def api_url(endpoint)
        "https://www.bloc.io/api/v1/#{endpoint}"
    end
end