defmodule Bulls do
  @moduledoc """
  Bulls keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

    def new do
        %{
            secret: generateAnswer(),
            guesses: [],
            guess: "",
            results: [],
            errorString: "",
        }
    end

    def guess(st, num) do
        %{st | guesses: MapSet.put(st.guesses, num) }
    end

    def generateAnswer do
        let digit1 = Enum.random(0..9);
        let digit2 = generateDifferentAnswer(digit1, 20, 20);
        let digit3 = generateDifferentAnswer(digit1, digit2, 20);
        let digit4 = generateDifferentAnswer(digit1, digit2, digit3);

        let out = digit1 + (10 * digit2) + (100 * digit3) + (1000 * digit4);
        Integer.to_string(out);
    end

    def generateDifferentAnswer(old1, old2, old3) do
        let new = Enum.random(0..9);
        if old1 == new or old2 == new or old3 == new do
            generateDifferentAnswer(old1, old2, old3);
        end
        if old1 != new and old2 != new and old3 != new do
            out = new;        
        end
    end

    def view(st) do
        out = "";
    end
end
