# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.110 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.110"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.110/stella-0.9.110-aarch64-apple-darwin.tar.gz"
      sha256 "b19524260c9f8ea22b5fd0474ac86396a158e7b2e3d26a23d69250c43b6ccc6a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.110/stella-0.9.110-x86_64-apple-darwin.tar.gz"
      sha256 "0bd2ccc6633581b3341c5e4463a86d69fa492fe9fcb0dfc903e50621369a865a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.110/stella-0.9.110-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "047469050ec2c5241181d580ef30d8cf99840d88a23881e81cac8b69476c8002"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.110/stella-0.9.110-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b65b0d34902b7e120fbd57b102cb402fc1840e96d3ac42233250b36d192dd24"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
