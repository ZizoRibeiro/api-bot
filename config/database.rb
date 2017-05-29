configure :test do
  set :database, {
    adapter: 'postgresql',
    enconding: 'utf8',
    database: 'api_bot_test',
    pool: 5,
    username: 'postgres',
    host: 'postgres'
  }
end

configure :development do
  set :database, {
    adapter: 'postgresql',
    encoding: 'utf8',
    database: 'api_bot_development',
    pool: 5,
    username: 'postgres',
    host: 'postgres'
  }
end

configure :production do
  db = 'postgres:///postgres/api_bot_production')

  set :database, {
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  }
end
