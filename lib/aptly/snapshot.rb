module Aptly
  extend self

  def create_snapshot_from_mirror name, mirror_name
    if list_snapshots.include? name
      raise AptlyError.new "Snapshot '#{name}' already exists"
    end

    cmd = 'aptly snapshot create '
    cmd += " #{name.to_safe} from mirror #{mirror_name.to_safe}"

    runcmd cmd
    return Snapshot.new name
  end

  def list_snapshots
    out = runcmd 'aptly snapshot list'
    parse_list out.lines
  end

  def snapshot_info name
    out = runcmd "aptly snapshot show #{name.to_safe}"
    parse_info out.lines
  end

  class Snapshot
    @name = ''
    @created_at = ''
    @description = ''
    @num_packages = 0

    def initialize name
      if !Aptly::list_snapshots.include? name
        raise AptlyError.new("Snapshot '#{name}' does not exist")
      end

      info = Aptly::snapshot_info name
      @name = info['Name']
      @created_at = info['Created At']
      @description = info['Description']
      @num_packages = info['Number of packages'].to_i
    end

    def drop
      Aptly::runcmd "aptly snapshot drop #{@name.to_safe}"
    end
  end
end
