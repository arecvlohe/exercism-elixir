defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    codons = 
      rna
      |> String.codepoints
      |> Enum.chunk(3)
      |> Enum.map(&Enum.join/1)
    Enum.reduce_while codons, {:ok, []}, fn v, acc -> 
      case of_codon(v) do
        {:ok, "STOP"} -> {:halt, acc}
        {:ok, val}    -> {:cont, {:ok, elem(acc, 1) ++ [val]}}
        {:error, _}   -> {:halt, {:error, "invalid RNA"}}
      end
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    cond do
      codon in ~w(UGU UGC)         -> {:ok, "Cysteine"}
      codon in ~w(UUA UUG)         -> {:ok, "Leucine"}
      codon in ~w(AUG)             -> {:ok, "Methionine"}
      codon in ~w(UUU UUC)         -> {:ok, "Phenylalanine"}
      codon in ~w(UCU UCC UCA UCG) -> {:ok, "Serine"}
      codon in ~w(UGG)             -> {:ok, "Tryptophan"}
      codon in ~w(UAU UAC)         -> {:ok, "Tyrosine"}
      codon in ~w(UAA UAG UGA)     -> {:ok, "STOP"}
      true                         -> {:error, "invalid codon"}
    end
  end
end

