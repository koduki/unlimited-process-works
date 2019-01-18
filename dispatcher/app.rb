require 'sinatra'

get '/' do
    'Hello, World'
end

get '/:user/add' do
    user = params[:user]
    response = IO.popen("docker run -e u=#{user} -e action=add -v /tmp/data:/data koduki/worker", "r+") {|io| io.gets}
    response
end

get '/:user/show' do
    user = params[:user]
    response = IO.popen("docker run -e u=#{user} -e action=show -v /tmp/data/data koduki/worker", "r+") {|io| io.gets}
    response
end

get '/:user/deposit/:amount' do
    user = params[:user]
    amount = params[:amount]
    response = IO.popen("docker run -e u=#{user} -e action=deposit -e arg=#{amount} -v /tmp/data:/data koduki/worker", "r+") {|io| io.gets}
    response
end
