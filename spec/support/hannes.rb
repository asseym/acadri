ActiveRecord::ConnectionAdapters::ConnectionPool.class_eval do
  def current_connection_id
    # Thread.current.object_id
    Thread.main.object_id
  end
end