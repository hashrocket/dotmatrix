class Clippy
  def paste
    IO.read("|pbpaste").chomp
  end

  def copy(string)
    IO.popen("pbcopy", "w") do |p|
      p.puts(string)
    end
    string
  end

  def <<(string)
    copy(paste + string)
  end

  def clear
    copy("")
  end

  def to_s
    paste
  end

  def inspect
    to_s
  end
end

def clippy
  @clippy ||= Clippy.new
  @clippy.copy yield if block_given?
  @clippy
end
