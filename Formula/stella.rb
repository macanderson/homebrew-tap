# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.460 / @SHA_*@ placeholders below with
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
  version "0.9.460"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.460/stella-0.9.460-aarch64-apple-darwin.tar.gz"
      sha256 "aa478ec66c3617ea0c1ab1184eaba15221417313e4e73eda04aa2f2ae6d70fbd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.460/stella-0.9.460-x86_64-apple-darwin.tar.gz"
      sha256 "1778828977739c2703f1411a5d341efc18db5b48d83de651b828f58420663099"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.460/stella-0.9.460-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "40de2063b60ad38dcccb7600b9b122ab3349c82cc3bc42df8e07e3f59859e3cb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.460/stella-0.9.460-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc84a0aeee96b293ce2dd793a0e329b876a134ad056a8c73b19466dc2795f7ac"
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
