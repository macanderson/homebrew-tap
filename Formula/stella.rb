# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.48 / @SHA_*@ placeholders below with
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
  version "0.5.48"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.48/stella-0.5.48-aarch64-apple-darwin.tar.gz"
      sha256 "15658c5490d9fd7836f7ca89d7114caf81efef0b2b4445b9110561ed899ec99b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.48/stella-0.5.48-x86_64-apple-darwin.tar.gz"
      sha256 "40ec4c2107c95db18b2006e0fc60b608c1efc44ce316b029ec6c9ce2a5614250"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.48/stella-0.5.48-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2780a9fc9f59d93871ff8e1206dd4c02bbdeb7ea058b6e5d975e03a02b924847"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.48/stella-0.5.48-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "33aea57712ddd81c33c8b7e3c551ec5bef715845a62b64730f1c53b6edc4e374"
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
