require 'sinatra'

get '/' do
    'Hello, World'
end

get '/account_summary' do
    user = params[:user]
    response = IO.popen("docker run --network unlimited-scaler_default -e action=account_summary -v /tmp/data:/data koduki/worker", "r+") {|io| io.gets}
    response
end

get '/:user/create' do
    user = params[:user]
    response = IO.popen("docker run --network unlimited-scaler_default -e u=#{user} -e action=create -v /tmp/data:/data koduki/worker", "r+") {|io| io.gets}
    response
end

get '/:user/show' do
    user = params[:user]
    response = IO.popen("docker run --network unlimited-scaler_default -e u=#{user} -e action=show -v /tmp/data:/data koduki/worker", "r+") {|io| io.gets}
    response
end

get '/:user/deposit/:amount' do
    user = params[:user]
    amount = params[:amount]
    response = IO.popen("docker run --network unlimited-scaler_default  -e u=#{user} -e action=deposit -e arg=#{amount} -v /tmp/data:/data koduki/worker", "r+") {|io| io.gets}
    response
end
