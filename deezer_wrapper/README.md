# DeezerWrapper

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://phoenix.hexdocs.pm/deployment.html).

## Learn more

* Official website: https://www.phoenixframework.org/
* Guides: https://phoenix.hexdocs.pm/overview.html
* Docs: https://phoenix.hexdocs.pm
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix


## Docker
To run the application using Docker:

### Generate the secret key base

```
$> mix phx.gen.secret
```
or 
```
$> openssl rand -base64 64
```

### Environment variables

***note: update the values in .env as needed***
```
$> cp .env.example .env
```

### Running the application

Start the application in detached mode:
```
$> docker-compose up --build -d
```

Stop the application or clean up:
```
$> docker-compose down
 or
$> docker-compose down --volumes --remove-orphans
```

### Run the migrations
```
$> docker compose exec app bin/migrate
```

### Run the tests

***note: install [jq](https://stedolan.github.io/jq/) to pretty-print JSON output: `brew install jq`***

```
curl "http://localhost:4000/api/artists/rema" | jq
```
