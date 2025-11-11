# Releasing psych-pure

This project uses GitHub Actions to automatically publish new versions to RubyGems when a version tag is pushed.

## One-time Setup

To enable automated releases, the repository owner needs to add a RubyGems API key as a GitHub secret:

1. Go to [RubyGems.org Account Settings](https://rubygems.org/settings/edit)
2. Navigate to API Keys
3. Create a new API key with push permissions for `psych-pure`
4. Copy the API key
5. Go to GitHub repository Settings → Secrets and variables → Actions
6. Click "New repository secret"
7. Name: `RUBYGEMS_API_KEY`
8. Value: Paste the API key from RubyGems
9. Click "Add secret"

This only needs to be done once.

## Releasing a New Version

1. Update the version in `lib/psych/pure/version.rb`
2. Update `CHANGELOG.md` with the new version and changes
3. Commit the changes:
   ```bash
   git add lib/psych/pure/version.rb CHANGELOG.md
   git commit -m "Bump version to X.X.X"
   ```
4. Create and push a tag:
   ```bash
   git tag vX.X.X
   git push origin main --tags
   ```

GitHub Actions will automatically:
- Build the gem
- Push it to RubyGems.org
- Create a GitHub Release with the gem file attached

## Manual Release (if needed)

If automated release fails or you need to publish manually:

```bash
gem build psych-pure.gemspec
gem push psych-pure-X.X.X.gem
```
