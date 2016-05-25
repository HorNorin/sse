class ChatsController < ApplicationController
  include ActionController::Live

  def index
  end

  def new
    response.headers['Content-Type'] = 'text/event-stream'
    client = Redis.new
    sse = SSE.new(response.stream)
    client.subscribe 'chat' do |on|
      on.message do |channel, message|
        sse.write(message, event: 'message')
      end
    end
  rescue IOError
    Rails.logger.info('Connection close')
  ensure
    sse.close
    client.quit
  end

  def create
    client = Redis.new
    client.publish('chat', { user: params[:user], message: params[:message]}.to_json)
    client.quit
    render nothing: true, status: 200
  end
end
