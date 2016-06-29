sysctl::conf { 'kernel.sem' :
  value => '10240 512000 64 9005'
}

sysctl::conf { 'kernel.semmsl' :
  value => '512000'
}

sysctl::conf { 'kernel.semmns' :
  value => '512000'
}

sysctl::conf { 'kernel.semopm' :
  value => '64'
}

sysctl::conf { 'kernel.semmni' :
  value => '9005'
}

