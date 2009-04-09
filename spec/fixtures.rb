Lifeline::User.fix {{
  :twitter_id => /\d{8,14}/.gen, 
  :name => "#{/\w{2,8}/.gen.capitalize} #{/\w{3,12}/.gen.capitalize}", 
  :token => /\w{8,16}/.gen, 
  :secret => /\w{8,16}/.gen
}}
