defmodule Mix.Tasks.Build do
  use Mix.Task
  
  @shortdoc "Build guides"
  
  def run(_) do
    IO.puts "Building guides"
    File.rm_rf "_guides"
    File.mkdir "_guides"
    guide hd(Mix.Project.config[:guides])
  end

  def guide(conf) do
    IO.puts "Building #{conf[:name]}"
    slugname = String.replace(String.downcase(conf[:name]), " ", "_")
    File.mkdir "_guides/#{slugname}"
    File.cp_r "guide", "_guides/#{slugname}"
    bindings = [name: conf[:name], json: conf[:json]]
    compiled = EEx.eval_file("_guides/#{slugname}/www/js/dontpanic.js.eex", bindings)
    File.write("_guides/#{slugname}/www/js/dontpanic.js", compiled)
    
    IO.puts "Collecting guideline JSON"
    HTTPoison.start
    case HTTPoison.get(conf[:json]) do
      %HTTPoison.Response{status_code: 200, body: body} ->
        bindings = [guidelines: body]
        File.write("_guides/#{slugname}/www/js/guidelines.js",
          EEx.eval_file("_guides/#{slugname}/www/js/guidelines.js.eex", bindings))
      %HTTPoison.Response{status_code: 404} ->
        IO.puts "Not found :("
    end

    opts = [into: "_guides/#{slugname}"]
    System.cmd "git", ["init"], opts
    System.cmd "git", ["add", "."], opts
    System.cmd "git", ["commit", "-a", "-m", "'Make it So.'"], opts
    System.cmd "git", ["remote", "add", "github", conf[:repo]], opts
    System.cmd "git", ["push", "github", "master", "-f"], opts
  end

end
