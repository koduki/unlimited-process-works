require 'sinatra'

def exec(action, params)
    env = params.map{|x|"-e #{x} "}.join
    response = IO.popen("docker run --network unlimited-process-works_default -e action=#{action} #{env} -v /tmp/data:/data koduki/worker", "r+") {|io| 
        io.each_line.map{|l|l}.join 
    }
    response
end

get '/' do
    'Hello, World'
end

get '/account_summary' do
    response = exec "account_summary", []
    response
end

get '/:user/create' do
    user = params[:user]
    response = exec "create", ["u=#{user}"]
    response
end

get '/:user/show' do
    user = params[:user]
    response = exec "show", ["u=#{user}"]
    response
end

get '/:user/deposit/:amount' do
    user = params[:user]
    amount = params[:amount]
    response = exec "deposit", ["u=#{user}", "arg=#{amount}"]
    response
end
