require 'mailgun'

class HomeController < ApplicationController
  def index
  end
  def write
    @mall = params[:email]
    @title = params[:title]
    @content = params[:content]
    
     new_post=Post.new
     new_post.title=@title
     new_post.content=@content
     new_post.save
     redirect_to "/list"
        mg_client = Mailgun::Client.new("key-9bef8e63547cd37965220dae8385e803")

        message_params =  {
                   from: 'unjedahe@gmail.com',
                   to:  @mall,
                   subject: @title,
                   text: @content
                  }

        result = mg_client.send_message('sandboxb238f075b966416aa723971a656168a1.mailgun.org
', message_params).to_h!
        message_id = result['id']
        message = result['message']
  end
  def list
    @every_post =Post.all.order("id desc")
  end  
  def destroy
    @one_post=Post.find(
    params[:post_id]
    )
    @one_post.destroy
    redirect_to "/list"
  end
  def update_view
    @one_post=Post.find (params[:post_id])
  end
  def silgae
    @one_post=Post.find(params[:post_id])
    @one_post.title= params[:title]
    @one_post.content= params[:content]
    @one_post.save
    redirect_to "/list"
  end
end
