class ProductsController < ApplicationController
    def get_all
        warehouses = helpers.open_warehouses
        products = helpers.open_products(warehouses)
        render json: products

    end
end