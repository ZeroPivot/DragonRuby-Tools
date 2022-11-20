require 'fileutils'
# last updated: 2022-11-19 
# last updated: 2022-08-30 1:38PM PST
# VERSION: v1.0.2f - initial release
# Purpose: Backup DragonRuby game files to a backup folder, replacing all files within it except for any folders not in the initial DragonRuby folder

# NOTE: This script will not work if the DragonRuby folder is not in the same directory as the backup folder

press_key_to_continue = true
backup_only = false
update_dirs = []
update_files = []

present_working_directory = Dir.pwd
backup_directory = "DragonBox_Backups"
dragonruby_directory = "DragonBox"
# directories that may not be detected by the script
update_dirs << './dragonruby-windows-amd64/.dragonruby'

puts "Ready to backup up DragonBox directory..."
puts "Present working directory: #{present_working_directory}"
puts "Press any key to continue..."
#exit
puts "Backing up DragonBox directory..."
# backup DragonBox directory into a .zip file
puts `powershell -Command "Compress-Archive -Path #{present_working_directory}/#{dragonruby_directory} -DestinationPath #{present_working_directory}/#{backup_directory}/DragonBox_timestamp_#{Time.now.to_i}.zip"`
#FileUtils.cp_r('./DragonBox', "../BashAsset_backups/DragonBox_#{Time.now.to_i}")

puts "Backup complete. Press any key to continue..."
# get unix time
exit if backup_only
gets if press_key_to_continue
puts "Loading directories and files to update..."
# Glob the dierctory of dragoneruby-windows-amd64's root, and save the paths to an array.
Dir.glob("#{present_working_directory}/dragonruby-windows-amd64/*") do |path|
  update_dirs << path if !File.file? path
  #puts path
end

puts "Directory folders to update:"
puts 
puts update_dirs

puts "Ready to update files..."
puts "Press any key to continue..."
gets if press_key_to_continue


#Glob the directory of dragonruby-windows-amd64 and only keep the files, leaving out the folders

Dir.glob('./dragonruby-windows-amd64/*').each do |file|
  if File.file?(file)
    update_files << file
  end
end
puts "Files to update: "
puts update_files
puts "Press any key to continue..."
gets if press_key_to_continue


puts "Present directory: #{Dir.pwd}"
update_dirs.each do |folder|
  puts "Removing #{folder}"
  FileUtils.rm_rf(Dir.pwd + '/DragonBox/' + folder)
  puts "Copying #{folder}"
  FileUtils.cp_r(folder, Dir.pwd + '/DragonBox/')
end

update_files.each do |file|
  puts "Copying & Replacing #{file}"
 FileUtils.cp_r(file, Dir.pwd + '/DragonBox/')
end

puts "Update complete. The updated dragonruby folder can be deleted now (dragonruby-pro-windows-amd64)"

