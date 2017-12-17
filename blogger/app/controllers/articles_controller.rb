class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :require_login, except: [:index, :show]

	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])

		# Not using @comment = @article.comments.new because it'll add a blank comment
		@comment = Comment.new
		@comment.article_id = @article.id
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		# TOO MUCH ABOUT MODEL
		# @article = Article.new
		# @article.title = params[:article][:title]
		# @article.body = params[:article][:body]

		# REDUNDANT CALLS
		# @article = Article.new(
		# 	title: params[:article][:title],
		# 	body: params[:article][:body])

		# BETTER WAY
		# @article = Article.new(params[:article])

		# BEST WAY (USES ARTICLES_HELPER.RB)
		@article = Article.new(article_params)

		@article.save

		flash.notice = "Article '#{@article.title}' created!"

		redirect_to article_path(@article)
	end

	def update
		@article = Article.find(params[:id])
		@article.update(article_params)

		flash.notice = "Article '#{@article.title}' updated!"

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "Article '#{@article.title}' deleted!"

		redirect_to articles_path
	end

end
