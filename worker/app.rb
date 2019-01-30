require 'sqlite3'
require 'pg'
require 'securerandom'

user = ENV['u']

case ENV['action']
when 'create' then
    sql = <<'EOS'
        CREATE TABLE IF NOT EXISTS account (
        id UUID,
        amount BIGINT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id)
        );
EOS

    db = SQLite3::Database.new("/data/#{user}.db")
    db.execute(sql)
    db.close

    puts "Hello, #{user}. Welcome Unlimited Process Works!"

when 'show' then
    money = nil
    db = SQLite3::Database.new("/data/#{user}.db")
    db.execute("SELECT SUM(amount) FROM account") do |row|
        money=row.first
    end
    db.close

    puts "#{user}'s account is #{money} yen."

when 'deposit' then
    arg = ENV['arg']
    amount = arg

    id = SecureRandom.uuid

    db = SQLite3::Database.new("/data/#{user}.db")
    db.execute("INSERT INTO ACCOUNT (id, amount) VALUES('#{id}', #{amount})")
    db.close

    require 'open-uri'
    open("http://aetl:8080/deposit/#{id}/#{user}/#{amount}")

    puts "#{user}'s account deposit #{amount} yen."

when 'account_summary' then
    con = PG::connect(:host => "global-db", :user => "postgres", :password => "mysecretpassword")
    result = con.exec("SELECT name, sum FROM v_account_summary;")
    result.each do |r|
        puts "#{r['name']}, #{r['sum']}"
    end
    con.finish
end