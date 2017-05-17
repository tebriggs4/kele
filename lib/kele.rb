require "httparty"

class Kele
    include HTTParty
    
    def initialize(email, password)
        response = self.class.post(api_url("sessions"), header: "application/json", body: {"email": email, "password": password})
        raise "Invalid userid or password" if (response.code == 401 || response.code == 404)
        @auth_token = response["auth_token"]
    end
    
    private
    
    def api_url(endpoint)
        "https://www.bloc.io/api/v1/#{endpoint}"
    end
end