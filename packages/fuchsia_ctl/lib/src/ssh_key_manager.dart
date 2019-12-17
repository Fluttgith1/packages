// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:meta/meta.dart';
import 'package:process/process.dart';

import 'operation_result.dart';

/// A wrapper for managing SSH key generation.
///
/// Implemented by [SystemSshKeyManager].
abstract class SshKeyManager {
  /// Create SSH key material suitable for paving and accessing a Fuchsia image.
  Future<OperationResult> createKeys({
    String destinationPath = '.ssh',
    bool force = false,
  });
}

/// A class that delegates creating SSH keys to the system `ssh-keygen`.
@immutable
class SystemSshKeyManager implements SshKeyManager {
  /// Creates a wrapper for ssh-keygen.
  ///
  /// The arguments must not be null, and will be used to spawn a ssh-keygen
  /// process and manipulate the files it creates.
  const SystemSshKeyManager({
    this.processManager = const LocalProcessManager(),
    this.fs = const LocalFileSystem(),
  })  : assert(processManager != null),
        assert(fs != null);

  /// The [ProcessManager] implementation to use when spawning ssh-keygen.
  final ProcessManager processManager;

  /// The [FileSystem] implementation to use when creating the authorized_keys
  /// file.
  final FileSystem fs;

  @override
  Future<OperationResult> createKeys({
    String destinationPath = '.ssh',
    bool force = false,
  }) async {
    final Directory sshDir = fs.directory(destinationPath);
    final File authorizedKeys = sshDir.childFile('authorized_keys');
    if (authorizedKeys.existsSync() && !force) {
      return OperationResult.success(info: 'Using previously generated keys.');
    }

    if (sshDir.existsSync()) {
      await sshDir.delete(recursive: true);
    }

    await sshDir.create();
    final File pkey = sshDir.childFile('pkey');
    final File pkeyPub = sshDir.childFile('pkey.pub');
    final ProcessResult result = await processManager.run(
      <String>[
        'ssh-keygen',
        '-t', 'ed25519', //
        '-f', pkey.path,
        '-q',
        '-N', '',
      ],
    );
    if (result.exitCode != 0) {
      return OperationResult.fromProcessResult(result);
    }

    final List<String> pkeyPubParts = pkeyPub.readAsStringSync().split(' ');
    await authorizedKeys
        .writeAsString('${pkeyPubParts[0]} ${pkeyPubParts[1]}\n');
    return OperationResult.fromProcessResult(result);
  }
}
