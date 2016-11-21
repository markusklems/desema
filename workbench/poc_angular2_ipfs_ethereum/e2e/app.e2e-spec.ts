import { MarketClientPage } from './app.po';

describe('market-client App', function() {
  let page: MarketClientPage;

  beforeEach(() => {
    page = new MarketClientPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
