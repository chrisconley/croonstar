class CallsController < ApplicationController

  def create
    render :dial
  end

  def index
    render :text => "hi"
  end

end