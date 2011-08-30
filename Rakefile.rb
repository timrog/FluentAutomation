#--------------------------------------
# Dependencies
#--------------------------------------
require 'albacore'
#--------------------------------------
# Debug
#--------------------------------------
#ENV.each {|key, value| puts "#{key} = #{value}" }
#--------------------------------------
# My environment vars
#--------------------------------------
@env_projectname = ENV['env_projectname']
@env_buildconfigname = ENV['env_buildconfigname']
@env_buildversion = ENV['env_buildversion']
@env_projectfullname = ENV['env_projectfullname']
@env_buildfolderpath = ENV['env_buildfolderpath']
@env_unitTestXmlResultsPath = ENV['env_unitTestXmlResultsPath']
@env_solutionfolderpath = "../Solution/"
#--------------------------------------
# Albacore flow controlling tasks
#--------------------------------------
desc "Creates ZIP and NuGet packages."
task :default => [:createZipPackage]
#, :createNuGetPackage]
#--------------------------------------
# Albacore tasks
#--------------------------------------
desc "Copy binaries to output."
task :copyBinaries do
  FileUtils.cp_r(FileList["SourceCode/bin/#{@env_buildconfigname}/*.*"], "#{@env_buildfolderpath}Binaries/")
end

desc "Creates ZIPs package of binaries folder."
zip :createZipPackage do |zip|
     zip.directories_to_zip "#{@env_buildfolderpath}Binaries/"
     zip.output_file = "#{@env_projectfullname}.zip"
	 zip.output_path = @env_buildfolderpath
end

#desc "Creates NuGet package"
#exec :createNuGetPackage do |cmd|
#  cmd.command = "NuGet.exe"
#  cmd.parameters = "pack #{@env_projectname}.nuspec -version #{@env_buildversion} -nodefaultexcludes -outputdirectory #{@env_buildfolderpath} -basepath #{@env_buildfolderpath}Binaries"
#end