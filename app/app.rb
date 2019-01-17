require 'sqlite3'

user = ENV['u']

case ENV['action']
when 'add' then
    db = SQLite3::Database.new("/data/#{user}.db")
    db.execute('CREATE TABLE IF NOT EXISTS ACCOUNT (MONEY INTEGER)')
    db.execute('INSERT INTO ACCOUNT (MONEY) VALUES(0)')
    db.close

    puts "Hello, #{user}. Welcome Unlimited World!"
when 'show' then
    money = nil
    db = SQLite3::Database.new("/data/#{user}.db")
    db.execute("SELECT MONEY FROM ACCOUNT") do |row|
        money=row.first
    end
    db.close

    puts "#{user}'s account is #{money} yen."
when 'deposit' then
    arg = ENV['arg']
    money = arg

    db = SQLite3::Database.new("/data/#{user}.db")
    db.execute("UPDATE ACCOUNT SET MONEY=MONEY+#{money}")
    db.close

    puts "#{user}'s account deposit #{money} yen."
end