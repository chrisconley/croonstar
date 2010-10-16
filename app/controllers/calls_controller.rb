class CallsController < ApplicationController

  def create
    render :dial, :layout => false
  end

  def index
    render :text => "hi", :layout => false
  end

end