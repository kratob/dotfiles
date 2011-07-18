require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('**/*.symlink', File::FNM_DOTMATCH)

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    full_path = linkable.split('/')
    file = full_path.last.split('.symlink')
    dir = full_path[1..-2].join('/')
    target_dir = ENV["HOME"]
    target_dir += "/#{dir}" if dir and dir != ''
    target = "#{target_dir}/#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        end
      end
      `mv "#{target}" "#{target}.backup"` if backup || backup_all
      if overwrite || overwrite_all
        FileUtils.rm_rf(target) 
        `ln -s "$PWD/#{linkable}" "#{target}"`
      end
    else
      `ln -s "$PWD/#{linkable}" "#{target}"` unless File.symlink?(target)
    end
  end
end
task :default => 'install'
