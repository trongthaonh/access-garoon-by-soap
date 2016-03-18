module Garoon
  class Message
    def initialize(client)
      @client = client
    end

    def get_thread_versions
      if block_given?
        parameters = {
          _start: Time.gm(1970, 1, 2, 0, 0, 0).iso8601
        }

        ret = @client.call_operation(:Message, :MessageGetThreadVersions, parameters)
        yield ret && ret[:thread_item] ? ret[:thread_item].ensure_array : nil
      end
    end

    def get_threads_by_id(thread_ids)
      if block_given?
        parameters = {
          thread_id: thread_ids
        }

        ret = @client.call_operation(:Message, :MessageGetThreadsById, parameters)
        yield ret && ret[:thread] ? ret[:thread].ensure_array : nil
      end
    end
  end
end
