module Messages
    
    def get_messages(page = nil)
        if (page == nil)
            response = self.class.get(api_url("message_threads"), user_auth)
        else
            response = self.class.get(api_url("message_threads?page=#{page}"), user_auth)
        end
        @messages = JSON.parse(response.body)
    end
    
    def create_message(user_id, recipient_id, token = nil, subject = nil, message)
        
        body = {
            "sender": user_id,
            "recipient_id": recipient_id,
            "subject": subject,
            "stripped-text": message
        }
        
        unless token.nil?
            body["token"] = token
        end
                
        response = self.class.post(api_url("messages"), body: body, headers: {"authorization" => @auth_token})
        puts response.code
    end
    
end