defmodule Mix.Tasks.Mishka.Ui.Add do
  use Igniter.Mix.Task
  @example "mix mishka.ui.gen.component component --example arg"

  def info(_argv, _composing_task) do
    %Igniter.Mix.Task.Info{
      # dependencies to add
      adds_deps: [],
      # dependencies to add and call their associated installers, if they exist
      installs: [],
      # An example invocation
      example: @example,
      # Accept additional arguments that are not in your schema
      # Does not guarantee that, when composed, the only options you get are the ones you define
      extra_args?: false,
      # A list of environments that this should be installed in, only relevant if this is an installer.
      only: nil,
      # a list of positional arguments, i.e `[:file]`
      positional: [],
      # Other tasks your task composes using `Igniter.compose_task`, passing in the CLI argv
      # This ensures your option schema includes options from nested tasks
      composes: [],
      # `OptionParser` schema
      schema: [],
      # CLI aliases
      aliases: []
    }
  end

  def igniter(igniter, _argv) do
    # extract positional arguments according to `positional` above
    IO.puts("We start Mishka task, loading =====>")

    config =
      [
        {String.to_atom("componentx"),
         [
           name: "componentx",
           args: [],
           optional: [],
           necessary: []
         ]}
      ]
      |> Enum.into([])

    direct_path =
      File.cwd!()
      |> Path.join(["priv", "/mishka_chelekom", "/components", "/componentx"])

    igniter
    |> Igniter.create_new_file(direct_path <> ".exs", "#{inspect(config)}", on_exists: :overwrite)
  end
end
