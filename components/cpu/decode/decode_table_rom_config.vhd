configuration cpu_decode_microcode of decode is
  for arch
    for core : decode_core
      use entity work.decode_core(arch)
        generic map (
          decode_type => MICROCODE,
          reset_vector => DEC_CORE_ROM_RESET);
    end for;
    for table : decode_table
      use entity work.decode_table(rom);
    end for;
  end for;
end configuration;
