require 'sinatra'

get '/' do
    'Hello, World'
end

get '/:user/add' do
    user = params[:user]
    response = IO.popen("docker run -e u=#{user} -e action=add -v `pwd`/data:/data koduki/app", "r+") {|io| io.gets}
    response
end

get '/:user/show' do
    user = params[:user]
    response = IO.popen("docker run -e u=#{user} -e action=show -v `pwd`/data:/data koduki/app", "r+") {|io| io.gets}
    p response
    response
end

get '/:user/deposit/:amount' do
    user = params[:user]
    amount = params[:amount]
    response = IO.popen("docker run -e u=#{user} -e action=deposit -e arg=#{amount} -v `pwd`/data:/data koduki/app", "r+") {|io| io.gets}
    response
end
