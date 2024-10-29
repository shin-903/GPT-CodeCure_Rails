class PostsController < ApplicationController
  # POST /create/post
  def create
    post = Post.new(post_params)

    # トランザクションでポスト作成とタグ付けを行う
    ActiveRecord::Base.transaction do
      # ポストを保存
      if post.save
        # 中間テーブルにタグを関連付ける
        params[:tag_ids].each do |tag_id|
          PostTag.create!(post_id: post.id, tag_id: tag_id)
        end

        # 成功時のレスポンス
        render json: {
          message: 'Post created successfully',
          post: {
            id: post.id,
            title: post.title,
            content: post.content,
            user_id: post.user_id
          }
        }, status: :created
      else
        render json: { error: post.errors.full_messages }, status: :bad_request
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PUT /update/post/:id
  def update
    post = Post.find_by(id: params[:id])

    # ポストが存在しない場合のエラーハンドリング
    if post.nil?
      render json: { error: 'Post not found' }, status: :not_found
      return
    end

    # トランザクションでポスト更新とタグの更新を行う
    ActiveRecord::Base.transaction do
      if post.update(post_update_params)
        # 既存のタグ関連を削除
        PostTag.where(post_id: post.id).destroy_all

        # 新しいタグを関連付ける
        params[:tag_ids].each do |tag_id|
          PostTag.create!(post_id: post.id, tag_id: tag_id)
        end

        # 成功時のレスポンス
        render json: { message: 'Post updated successfully' }, status: :ok
      else
        render json: { error: post.errors.full_messages }, status: :bad_request
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    post = Post.find_by(id: params[:id])

    # ポストが存在しない場合のエラーハンドリング
    if post.nil?
      render json: { error: 'Post not found' }, status: :not_found
      return
    end

    # トランザクションでポストと関連する中間テーブルのレコードを削除
    ActiveRecord::Base.transaction do
      PostTag.where(post_id: post.id).destroy_all
      post.destroy

      render json: { message: 'Post deleted successfully' }, status: :ok
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # Strong parameters
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def post_update_params
    params.require(:post).permit(:title, :content)
  end
end