# Bookshelf

## Development

### Build container and modules

```
docker compose build
docker compose run --rm app bin/setup
```

### Insert seed

```
docker compose run --rm app bin/rails db:seed
```

### Startup

```
docker compose up
```

### Before pull request

This project uses the overcommit gem. Run this command before committing. To pull request code with no warnings, execute this step.

```
bundle install
overcommit --install
```

## Layout

- [Stacked Layouts - Tailwind UI](https://tailwindui.com/components/application-ui/application-shells/stacked#component-10058606cac5398d7fa2c73b64089874)
