enum PostOptionsEnum{
  delete(option:'Delete'),
  edit(option:'Edit');

  final String option;
  const PostOptionsEnum({required this.option});
}
