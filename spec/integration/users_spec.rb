require 'swagger_helper'

RSpec.describe 'Users Endpoints' do
  path '/users/{id}' do
    get 'show a user' do
      tags 'users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, description: 'The primary id of your fancy users'

      response 200, 'yay user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            awesome: { type: :boolean }
          },
          required: ['id', 'awesome']

        let(:id) { User.create(name: 'Oscar Janosch', awesome: true).id }
        run_test!
      end

      response 404, 'oh noes, user not found' do
        schema '$ref' => '#/definitions/error'
        let(:id) { 12345 }
        run_test!
      end
    end
  end

  path '/users' do
    get 'list of awesome users' do
      tags 'users'
      produces 'application/json'
      parameter name: :awesome, in: :path, type: :boolean, enum: ['true', 'false'], description: 'The users awesomeness'

      response 200, 'yay user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            awesome: { type: :boolean }
          },
          required: ['id', 'awesome']

        let(:id) { User.create(name: 'Oscar Janosch', awesome: true).id }
        run_test!
      end
    end
  end
end
