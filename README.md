# Ryotube

A modern Rails application built with Docker, PostgreSQL, and the latest technologies.

## Tech Stack

- **Ruby**: Latest (ruby:latest Docker image)
- **Rails**: 8.1.2
- **PostgreSQL**: 18
- **Docker**: For containerization
- **Docker Compose**: For orchestration

## Prerequisites

### Installing Docker on macOS 12 (Monterey)

Since you're running macOS 12, you'll need to install an older version of Docker Desktop that's compatible with your OS:

1. Visit the [Docker Desktop release notes](https://docs.docker.com/desktop/release-notes/)
2. Download Docker Desktop 4.24 or earlier (compatible with macOS 12)
3. Install the downloaded .dmg file
4. Start Docker Desktop from Applications

Alternatively, you can upgrade to macOS 13 Sonoma or later to use the latest Docker Desktop version.

## Setup Instructions

### 1. First-time Setup

Once Docker is installed and running:

```bash
# Navigate to the project directory
cd ryotube

# Build the Docker images
docker compose build

# Start the containers (this will initialize Rails on first run)
docker compose up
```

The `entrypoint.sh` script will automatically:
- Install Rails if not already present
- Create a new Rails application with PostgreSQL
- Configure the database settings

### 2. Create and Setup Database

In a new terminal window:

```bash
# Create the database
docker compose exec web rails db:create

# Run migrations (if any)
docker compose exec web rails db:migrate
```

### 3. Access the Application

Open your browser and visit:
```
http://localhost:3000
```

## Common Commands

### Starting the Application

```bash
docker compose up
```

Or run in detached mode:
```bash
docker compose up -d
```

### Stopping the Application

```bash
docker compose down
```

### View Logs

```bash
docker compose logs -f web
```

### Run Rails Console

```bash
docker compose exec web rails console
```

### Run Database Migrations

```bash
docker compose exec web rails db:migrate
```

### Generate Models/Controllers

```bash
docker compose exec web rails generate model User name:string email:string
docker compose exec web rails generate controller Users
```

### Run Tests

```bash
docker compose exec web rails test
```

### Install New Gems

After adding gems to the Gemfile:

```bash
docker compose build
docker compose up
```

## Project Structure

```
ryotube/
├── Dockerfile              # Docker image configuration
├── docker-compose.yml      # Docker services configuration
├── entrypoint.sh          # Container initialization script
├── Gemfile                # Ruby gem dependencies
├── Gemfile.lock           # Locked gem versions
├── .gitignore             # Git ignore rules
└── README.md              # This file
```

After first run, Rails will generate additional directories:
- `app/` - Application code (models, views, controllers)
- `config/` - Configuration files
- `db/` - Database migrations and schema
- `public/` - Static files
- `test/` - Test files

## Environment Variables

The application uses the following environment variables (configured in docker-compose.yml):

- `DATABASE_HOST`: PostgreSQL host (default: db)
- `DATABASE_USER`: PostgreSQL username (default: postgres)
- `DATABASE_PASSWORD`: PostgreSQL password (default: password)
- `RAILS_ENV`: Rails environment (default: development)

## Troubleshooting

### Port Already in Use

If port 3000 or 5432 is already in use, modify the port mappings in `docker-compose.yml`:

```yaml
ports:
  - "3001:3000"  # Change host port from 3000 to 3001
```

### Permission Issues

If you encounter permission errors:

```bash
docker compose exec web bundle install
docker compose restart web
```

### Rebuild from Scratch

To completely rebuild the containers:

```bash
docker compose down -v
docker compose build --no-cache
docker compose up
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests
4. Submit a pull request

## License

This project is available for use under the MIT License.
