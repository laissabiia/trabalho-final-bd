INSERT INTO tipo_usuario (nome) VALUES
  ('aluno'),
  ('professor'),
  ('gestor');
  
INSERT INTO escola (nome, cnpj) VALUES
  ('Ced 01 do Itapoa', '12.345.678/0001-90'),
  ('Cef 01 do Gama', '23.456.789/0001-01'),
  ('Ec 08 de Taguatinga', '34.567.890/0001-12'),
  ('Ec 106 Norte', '45.678.901/0001-23');

  INSERT INTO area (nome) VALUES
  ('Robótica'),
  ('Algorítmos'),
  ('Computação');

  INSERT INTO modalidade (nome) VALUES
  ('Ensino Médio'),
  ('Ensino Fundamental'),
  ('EJA');

INSERT INTO instituicao (nome, tipo, cnpj) VALUES
  ('UnB', 'Universidade', '00.000.000/0001-00'),
  ('CeuB', 'Centro Universitário', '11.111.111/0001-11');

  INSERT INTO curso (nome, id_instituicao) VALUES
  ('Licenciatura em Computação', 1),
  ('Matemática', 1),
  ('Português', 1),
  ('Licenciatura em Computação', 2),
  ('Matemática', 2),
  ('Português', 2);
