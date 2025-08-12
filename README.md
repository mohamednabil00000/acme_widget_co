# ACME Widget Co - E-commerce Application

ACME Widget Co is a modern e-commerce application built with Ruby on Rails 8, featuring a shopping basket system and product management.

## 🚀 Features

- **Product Management**: Create, and manage widget products
- **Shopping Basket**: Add items, manage quantities
- **Checkout System**: Process orders and manage basket state
- **Docker Support**: Containerized development and deployment
- **PostgreSQL Database**: Robust data storage

## 🏗️ Architecture

- **Backend**: Ruby on Rails 8 with PostgreSQL
- **Database**: PostgreSQL with Active Record

## 📋 Prerequisites

- Ruby 3.2.1+
- Rails 8
- PostgreSQL 16+
- Docker & Docker Compose (for containerized setup)

## 🐳 Running with Docker (Recommended)

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/mohamednabil00000/acme_widget_co.git
   cd acme_widget
   ```

2. **Start the application**
   ```bash
   cd docker
   docker-compose up --build
   ```

3. **Access the application**
   - Main app: http://localhost:3000
   - Database: PostgreSQL on port 5432


### Docker Services

- **web**: Rails application server
- **db**: PostgreSQL database
- **volumes**: Persistent data storage

## 🖥️ Manual Setup

### 1. Install Dependencies

```bash
# Install Ruby dependencies
bundle install

# Install Node.js dependencies (if using yarn)
yarn install
```

### 2. Database Setup

```bash
# Create database
bundle exec rails db:create

# Run migrations
bundle exec rails db:migrate

# Seed initial data
bundle exec rails db:seed
```

### 3. Environment Configuration

Create `.env` file in the root directory:

```bash
# Database
DATABASE_URL=postgresql://localhost:5432/acme_widget_development

# Rails
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_here
```

### 4. Start the Application

```bash
# Start Rails server
bundle exec rails server
```

### 5. Access the Application

- Main app: http://localhost:3000
- Database: PostgreSQL on localhost:5432

## 🗄️ Database

### Models

- **Item**: Widget items with code, name, and price
- **Basket**: Shopping cart for users
- **BasketItem**: Individual items in a basket

### Initial Data

The application comes with sample items:
- Red Widget (R01) - $32.95
- Green Widget (G01) - $24.95
- Blue Widget (B01) - $7.95

## 🧪 Testing the examples exist in the assignment
```bash
bundle exec rspec spec/controllers/api/v1/baskets_controller_spec.rb:28

# if you want to run all specs
bundle exec rspec
```

## Postman collection
```bash
There is a postman script that contains all the endpoints. It exists in the root of the project called "acma widget co.postman_collection.json"
```

## 📁 Project Structure

```
acme_widget_co/
├── app/                    # Application code
│   ├── controllers/        # Controllers
│   ├── models/            # Models
│   ├── views/             # Views and templates
│   ├── assets/            # CSS, JS, images
│   ├── serializers/       # serializers files
│   └── services/          # Business logic services
├── config/                # Configuration files
├── db/                    # Database files
├── docker/                # Docker configuration
├── rspec/                 # Test files
└── README.md             # This file
```

## 🌐 API Endpoints

### items
- `GET /api/v1/items` - List all items

### Baskets
- `POST /api/v1/baskets` - Create new basket
- `GET /api/v1/baskets/:id/checkout` - Checkout basket

### Basket Items
- `GET /api/v1/baskets/:basket_id/basket_items` - List basket items
- `POST /api/v1/baskets/:basket_id/basket_items` - Add item to basket

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check PostgreSQL is running
   - Verify database credentials
   - Ensure database exists

2. **Port Already in Use**
   - Change port in `docker-compose.yml`
   - Kill process using the port

3. **Permission Denied**
   - Check file permissions
   - Ensure proper ownership

### Logs

```bash
# View Rails logs
docker-compose logs -f web

# View database logs
docker-compose logs -f db

# View all logs
docker-compose logs -f
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the troubleshooting section
- Review the Rails documentation

## 🔄 Updates

To update the application:

```bash
# Pull latest changes
git pull origin main

# Update dependencies
bundle install

# Run migrations
bundle exec rails db:migrate

# Restart services
docker-compose restart
```

---

**Happy coding! 🎉**
