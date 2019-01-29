require 'pg'
require 'sinatra'

get '/deposit/:id/:user/:amount' do
    id = params[:id]
    user = params[:user]
    amount = params[:amount]
    
    Thread.new do 
        con = PG::connect(:host => "global-db", :user => "postgres", :password => "mysecretpassword")
        con.exec("INSERT INTO ACCOUNT (id, name, amount) VALUES('#{id}', '#{user}', #{amount})")
        con.exec("REFRESH MATERIALIZED VIEW v_account_summary")
        con.finish
        puts "synchronized #{id}"
    end
end
