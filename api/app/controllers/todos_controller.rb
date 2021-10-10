class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @state = params[:state].to_i
    @limit = params[:limit].to_i
    logger.debug("ログ出力 : #{@state}")
    logger.debug("State存在 : #{params[:state]}")
    logger.debug("params : #{params}")

    @todos = Todo.all

    if @state > 0
      @todos = @todos.where(state: @state)
    end

    if @limit > 0
      @todos = @todos.limit(@limit)
    end

    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo_params = params;
    @id = @todo_params[:id].to_i
    @state = @todo_params[:state].to_i
    @title = @todo_params[:title]
    @description = @todo_params[:description]

    logger.debug("params: #{@todo_params}");

    @createParam = {};
    @createParam[:title] = @title;
    @createParam[:description] = @description;
    @createParam[:state] = 1;

    @todo = Todo.new(@createParam)
    if @todo.save
      render json: @todo, status: :created, location: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    @todo_params = params;
    @id = @todo_params[:id].to_i
    @state = @todo_params[:state].to_i
    @title = @todo_params[:title]
    @description = @todo_params[:description]

    @updateTodo = {}

  if @title != nil
      @updateTodo[:title] = @title
    end
    if @description != nil
      @updateTodo[:description] = @description
    end
    if @state != nil && @state >= 0
      @updateTodo[:state] = @state
    end
    logger.debug("updateTodo #{@updateTodo}.");

    if @todo.update(@updateTodo)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).
      (:group_id, :state, :title)
    end
end
