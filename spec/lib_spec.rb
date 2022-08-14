require 'spec_helper'

RSpec.describe JapMag do
  #let(:rails_app) { Class.new { include JapMag } }

  describe 'current_controller_action_in?' do
    let(:rails_app) { RailsApp.new(controller: 'page', action: 'index') }

    context 'string' do
      it 'returns true when controller matches' do
        s = 'page'

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when more than one controlers matches' do
        s = 'page users'

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when controller#action matches' do
        s = 'page#index'

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when more than one controler#action matches' do
        s = 'page#index users#new users#create'

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when it is a mix of controller and controler#action' do
        s = 'page users users#new users#create'

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns false when controller doesnot match' do
        s = 'page1'

        expect(rails_app.current_controller_action_in?(s)).to be(false)
      end
    end

    context 'splat' do
      it 'returns true when controller matches' do
        s = *%w(page)

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when more than one controlers matches' do
        s = *%w(page users)

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when controller#action matches' do
        s = *%w(page#index)

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when more than one controler#action matches' do
        s = *%w(page#index users#new users#create)

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns true when it is a mix of controller and controler#action' do
        s = *%w(page users users#new users#create)

        expect(rails_app.current_controller_action_in?(s)).to be(true)
      end

      it 'returns false when controller doesnot match' do
        s = *%w(page1)

        expect(rails_app.current_controller_action_in?(s)).to be(false)
      end
    end
  end
end
